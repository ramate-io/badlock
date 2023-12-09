#include "Extractor.h"

#include "llvm/IR/Instruction.h"

std::string Extractor::instToString(Instruction *L) {
    uintptr_t id = reinterpret_cast<uintptr_t>(L);
    std::string instrStr;
    llvm::raw_string_ostream rso(instrStr);
    L->print(rso);
    return rso.str();
}

void Extractor::addDef(const InstMapTy &InstMap, Value *X, Instruction *L) {
  if (InstMap.find(X) == InstMap.end())
    return;
  DefFile << toString(X) << "\t" << toString(L) << "\n";
}

void Extractor::addUse(const InstMapTy &InstMap, Value *X, Instruction *L) {
  if (Constant *C = dyn_cast<Constant>(X))
    return;
  if (InstMap.find(X) == InstMap.end())
    return;
  UseFile << toString(X) << "\t" << toString(L) << "\n";
}

void Extractor::addLock(const InstMapTy &InstMap, Value *X, Instruction *L) {
  if (Constant *C = dyn_cast<Constant>(X))
    return;
  if (InstMap.find(X) == InstMap.end())
    return;
  DivFile << toString(X) << "\t" << toString(L) << "\n";
}

void Extractor::addRelease(const InstMapTy &InstMap, Value *X, Instruction *L) {
  SanitizerFile << toString(L) << "\n";
}

void Extractor::addNext(const InstMapTy &InstMap, Instruction *X,
                        Instruction *Y) {
  NextFile << toString(X) << "\t" << toString(Y) << "\n";
};

/**
 * @brief Collects Datalog facts for each instruction to corresponding facts
 * file.
 */
void Extractor::extractConstraints(const InstMapTy &InstMap, Instruction *I) {
  /**
   * TODO: For each predecessor P of instruction I,
   *       add a new fact in the `next` relation.
   */
  for(auto P : getPredecessors(I))
    addNext(InstMap, P, I);

  /**
   * TODO:
   *
   *   For each of the instruction add appropriate facts:
   *     Add `def` and `use` relations.
   *   For `BinaryOperator` instructions involving division:
   *     Add a fact for the `div` relation.
   *   For `CallInst` instructions:
   *     Add a `def` relation only if it returns a non-void value.
   *     If its a call to tainted input,
   *       Add appropriate fact to `taint` relation.
   *     If its a call to sanitize,
   *       Add appropriate fact to `sanitizer` relation.
   *
   * NOTE: Many Values may be used in a single instruction,
   *       but at most one Value can be defined in one instruction.
   * NOTE: You can use `isTaintedInput()` and `isSanitizer()` function
   *       to check if a particular CallInst is a tainted input
   *       or sanitize respectively.
   */

  if (AllocaInst *AI = dyn_cast<AllocaInst>(I)) {
    // do nothing, alloca is just a declaration.
  } else if (StoreInst *SI = dyn_cast<StoreInst>(I)) {

    addDef(
      InstMap,
      SI->getPointerOperand(),
      SI
    );

    addUse(
      InstMap,
      SI->getValueOperand(),
      SI
    );

  } else if (LoadInst *LI = dyn_cast<LoadInst>(I)) {

    addUse(
      InstMap,
      LI->getPointerOperand(),
      LI
    );

    addDef(
      InstMap,
      LI,
      LI
    );

  } else if (BinaryOperator *BI = dyn_cast<BinaryOperator>(I)) {

    // add use statements for the first two operands
    addDef(
      InstMap,
      BI,
      BI
    );

    addUse(
      InstMap,
      BI->getOperand(0),
      BI
    );
    addUse(
      InstMap,
      BI->getOperand(1),
      BI
    );

    unsigned OpCode = BI->getOpcode();
    
    switch(OpCode){

      case llvm::Instruction::UDiv:
      case llvm::Instruction::SDiv: 
      {
        addDiv(InstMap, I->getOperand(1), I);
        break;
      }

      default:
        break;

    }

  } else if (CallInst *CI = dyn_cast<CallInst>(I)) {

    errs() << "CallInst: " << *CI << "\n";
    addDef(
      InstMap,
      CI,
      CI
    );

    errs() << "Extracting args...\n";
    for (unsigned i = 0; i < CI->getNumOperands() - 1; ++i) {
      Value *Arg = CI->getArgOperand(i);
       addUse(
        InstMap,
        Arg,
        CI
      );
    }

    errs() << "Checking taint...\n";
    if (isTaintedInput(CI)){
      errs() << "Is tainted input...\n";
      addTaint(InstMap, CI);
    } else if (isSanitizer(CI)){
      errs() << "Is sanitizer...\n";
      addSanitizer(InstMap, CI);
    }
    errs() << "Done with CallInst...\n";

  } else if (CastInst *CI = dyn_cast<CastInst>(I)) {

    addDef(
      InstMap,
      CI,
      CI
    );

    addUse(
      InstMap,
      CI->getOperand(0),
      CI
    );

  } else if (CmpInst *CI = dyn_cast<CmpInst>(I)) {

    addDef(
      InstMap,
      CI,
      CI
    );

    addUse(
      InstMap,
      CI->getOperand(0),
      CI
    );

    addUse(
      InstMap,
      CI->getOperand(0),
      CI
    );

  }
}

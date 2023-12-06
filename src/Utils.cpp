#include "Utils.h"

#include "llvm/IR/CFG.h"

const char *WHITESPACES = " \t\n\r";

std::string toString(Value *Val) {
    std::string Code;
    raw_string_ostream SS(Code);
    Val->print(SS);
    Code.erase(0, Code.find_first_not_of(WHITESPACES));

    uintptr_t id = reinterpret_cast<uintptr_t>(Val);
    std::string idStr = " @ ID: " + std::to_string(id);

    auto RetVal = Code.substr(0, Code.find_first_of(WHITESPACES));
    if (RetVal == "ret" || RetVal == "br" || RetVal == "store") {
        return Code + idStr;
    }
    if (RetVal == "i1" || RetVal == "i8" || RetVal == "i32" || RetVal == "i64") {
        RetVal = Code;
    }
    return RetVal + idStr;
}


std::vector<Instruction *> getPredecessors(Instruction *I) {
  std::vector<Instruction *> Ret;
  BasicBlock *BB = I->getParent();
  for (BasicBlock::reverse_iterator It = BB->rbegin(), E = BB->rend(); It != E;
       ++It) {
    if (&(*It) == I) {
      ++It;
      if (It == E) {
        for (pred_iterator Pre = pred_begin(BB), BE = pred_end(BB); Pre != BE;
             ++Pre)
          Ret.push_back(&(*((*Pre)->rbegin())));
      } else {
        Ret.push_back(&(*It));
      }
      break;
    }
  }
  return Ret;
}

bool isTaintedInput(CallInst *CI) {
  Function *calledFunction = CI->getCalledFunction();
  if (calledFunction && calledFunction->hasName())
    return calledFunction->getName().equals("_acquire_lock");
  return false;
}

bool isSanitizer(CallInst *CI) {
  Function *calledFunction = CI->getCalledFunction();
  if (calledFunction && calledFunction->hasName())
    return calledFunction->getName().equals("_release_lock");
  return false;
}

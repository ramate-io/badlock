use crepe::crepe;
use std::collections::{HashMap, HashSet};

crepe! {

    @input
    pub struct Def(usize, usize);

    @input
    pub struct UseVar(usize, usize);

    @input
    pub struct Next(usize, usize);

    @input
    pub struct Wrap(usize, usize);

    @input
    pub struct Lock(usize, usize);

    @input
    pub struct Release(usize, usize);


    @output
    pub struct Kill(usize, usize);

    @output
    pub struct In(usize, usize);

    @output
    pub struct Out(usize, usize);

    @output
    pub struct Deadlock(usize, usize);

    @output
    pub struct Edge(usize, usize);

    @output
    pub struct Path(usize, usize);

    // Reaching definitions
    Kill(curr_inst, old_inst) <- Def(var, curr_inst), Def(var, old_inst);
    Out(inst, inst) <- Def(_, inst);
    Out(inst, def_inst) <- In(inst, def_inst), !Kill(inst, def_inst);
    In(inst, def_inst) <- Out(prev_inst, def_inst), Next(prev_inst, inst);

    // Deadlock taint
    Edge(from_inst, to_inst) <- Def(var, from_inst), UseVar(var, to_inst), In(to_inst, from_inst);
    Path(from_inst, to) <- Lock(from_inst, _), Edge(from_inst, to);
    Path(prev, next) <- Path(prev, almost), !Release(almost, _), Edge(almost, next);
    Deadlock(inst, var) <- Lock(inst, var), Path(_, inst);

}

pub fn detect_reentrant_deadlock(

) -> bool {

    let mut runtime = Crepe::new();

    /*runtime.extend(vec![
        Def(Symbol([0; 128]), Symbol([0; 128])), // define 0 at 0
        Def(Symbol([1; 128]), Symbol([1; 128])), // define 1 at 1
        Def(Symbol([0; 128]), Symbol([2; 128])), // define 0 at 2
    ]);

    runtime.extend(vec![
        UseVar(Symbol([0; 128]), Symbol([0; 128])), // use 0 at 0
        UseVar(Symbol([1; 128]), Symbol([1; 128])), // use 1 at 1
        UseVar(Symbol([0; 128]), Symbol([2; 128])), // use 0 at 2
        UseVar(Symbol([0; 128]), Symbol([3; 128])), // use 0 at 3
        
    ]);

    runtime.extend(vec![
        // build out predecessors
        Next(Symbol([0; 128]), Symbol([1; 128])), 
        Next(Symbol([0; 128]), Symbol([2; 128])),
        Next(Symbol([0; 128]), Symbol([3; 128])),
        Next(Symbol([0; 128]), Symbol([4; 128])),
        Next(Symbol([1; 128]), Symbol([2; 128])),
        Next(Symbol([1; 128]), Symbol([3; 128])),
        Next(Symbol([1; 128]), Symbol([4; 128])),
        Next(Symbol([2; 128]), Symbol([3; 128])),
        Next(Symbol([2; 128]), Symbol([4; 128])),
        Next(Symbol([3; 128]), Symbol([4; 128])),
    ]);

    runtime.extend(vec![
        Lock(Symbol([0; 128]), Symbol([0; 128])), // lock on 0 at 0
        Lock(Symbol([2; 128]), Symbol([0; 128])), // lock on 0 at 2
    ]);

    let (
        kill,
        in_,
        out,
        deadlock,
        edge,
        path
    )  = runtime.run();

    for In(def_inst, inst) in in_ {
        println!("In({}, {})", def_inst.0[0], inst.0[0]);
    }

    for Out(inst, def_inst) in out {
        println!("Out({}, {})", inst.0[0], def_inst.0[0]);
    }

    for Kill(curr_inst, old_inst) in kill {
        println!("Kill({}, {})", curr_inst.0[0], old_inst.0[0]);
    }

    for Edge(from_inst, to_inst) in edge {
        println!("Edge({}, {})", from_inst.0[0], to_inst.0[0]);
    }

    for Path(prev, next) in path {
        println!("Path({}, {})", prev.0[0], next.0[0]);
    }

    for Deadlock(inst, var) in deadlock {
        println!("Deadlock({}, {})", inst.0[0], var.0[0]);
    }*/

    false

}


#[derive(Clone, Debug)]
pub struct InsertionOrderMap<Value> {
    pub mapping : HashMap<Value, usize>
}

impl <Value> InsertionOrderMap<Value> 
where 
    Value : std::cmp::Eq + std::hash::Hash
{

    pub fn new() -> Self {
        Self {
            mapping : HashMap::new()
        }
    }

    pub fn map(&mut self, value : Value) -> usize {

        match self.mapping.get(&value) {
            Some(index) => return index.clone(),
            None => {
                let index = self.mapping.len();
                self.mapping.insert(value, index.clone());
                return index;
            }
        }

    }


}

pub trait Extendable<T> {

    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
        where Iter : IntoIterator<Item = T>;

}


#[derive(Clone)]
pub struct DealockPriors {
    pub defs : HashSet<Def>,
    pub use_vars : HashSet<UseVar>,
    pub nexts : HashSet<Next>,
    pub wraps : HashSet<Wrap>,
    pub locks : HashSet<Lock>,
    pub releases : HashSet<Release>
}

impl DealockPriors {

    pub fn new() -> Self {
        Self {
            defs : HashSet::new(),
            use_vars : HashSet::new(),
            nexts : HashSet::new(),
            wraps : HashSet::new(),
            locks : HashSet::new(),
            releases : HashSet::new()
        }
    }

    /*pub fn add_def(&mut self, def : Def) -> &mut Self {
        self.defs.insert(def);
        self
    }

    pub fn add_use_var(&mut self, use_var : UseVar) -> &mut Self {
        self.use_vars.insert(use_var);
        self
    }

    pub fn add_next(&mut self, next : Next) -> &mut Self {
        self.nexts.insert(next);
        self
    }

    pub fn add_wrap(&mut self, wrap : Wrap) -> &mut Self {
        self.wraps.insert(wrap);
        self
    }

    pub fn add_lock(&mut self, lock : Lock) -> &mut Self {
        self.locks.insert(lock);
        self
    }

    pub fn add_release(&mut self, release : Release) -> &mut Self {
        self.releases.insert(release);
        self
    }*/

    pub fn compute_facts(&self) -> (HashSet<Kill>, HashSet<In>, HashSet<Out>, HashSet<Deadlock>, HashSet<Edge>, HashSet<Path>) {

        let mut runtime = Crepe::new();

        runtime.extend(self.defs.iter().cloned());
        runtime.extend(self.use_vars.iter().cloned());
        runtime.extend(self.nexts.iter().cloned());
        runtime.extend(self.wraps.iter().cloned());
        runtime.extend(self.locks.iter().cloned());
        runtime.extend(self.releases.iter().cloned());

        runtime.run()

    }

    pub fn compute_reentrant_deadlocks(&self) -> HashSet<Deadlock> {

        let (
            _kill,
            _in_,
            _out,
            deadlock,
            _edge,
            _path
        )  = self.compute_facts();

        deadlock

    }

}

impl Extendable<Def> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Def> {
        self.defs.extend(values);
        self
    }
}

impl Extendable<UseVar> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = UseVar> {
        self.use_vars.extend(values);
        self
    }
}

impl Extendable<Next> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Next> {
        self.nexts.extend(values);
        self
    }
}

impl Extendable<Wrap> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Wrap> {
        self.wraps.extend(values);
        self
    }
}

impl Extendable<Lock> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Lock> {
        self.locks.extend(values);
        self
    }
}

impl Extendable<Release> for DealockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Release> {
        self.releases.extend(values);
        self
    }
}

pub mod test {

    use super::*;

    #[test]
    pub fn test_reentrant_deadlocks_simple_lock() {

        let mut facts = DealockPriors::new();
        facts.extend(vec![
            Def(0, 0),
            Def(1, 1),
            Def(0, 2),
        ]);

        facts.extend(vec![
            UseVar(0, 0),
            UseVar(1, 1),
            UseVar(0, 2),
            UseVar(0, 3),
        ]);

        facts.extend(vec![
            Next(0, 1),
            Next(0, 2),
            Next(0, 3),
            Next(0, 4),
            Next(1, 2),
            Next(1, 3),
            Next(1, 4),
            Next(2, 3),
            Next(2, 4),
            Next(3, 4),
        ]);

        facts.extend(vec![
            Lock(0, 0),
            Lock(2, 0),
        ]);

        let deadlocks = facts.compute_reentrant_deadlocks();

        assert_eq!(deadlocks.len(), 1);
        assert!(deadlocks.contains(&Deadlock(2, 0)));

    }

    #[test]
    pub fn test_reentrant_deadlocks_simple_lock_and_release() {

        let mut facts = DealockPriors::new();

        facts.extend(vec![
            Def(0, 0),
            Def(1, 1),
            Def(0, 2),
        ]);

        facts.extend(vec![
            UseVar(0, 0),
            UseVar(1, 1),
            UseVar(0, 2),
            UseVar(0, 3),
        ]);

        facts.extend(vec![
            Next(0, 1),
            Next(0, 2),
            Next(0, 3),
            Next(0, 4),
            Next(1, 2),
            Next(1, 3),
            Next(1, 4),
            Next(2, 3),
            Next(2, 4),
            Next(3, 4),
        ]);

        facts.extend(vec![
            Lock(0, 0),
            Lock(3, 0),
        ]);

        facts.extend(vec![
            Release(2, 0),
        ]);

        let (
            kill,
            in_,
            out,
            deadlock,
            edge,
            path
        )  = facts.compute_facts();

        for Path(prev, next) in path {
            println!("Path({}, {})", prev, next);
        }

        // assert!(deadlocks.is_empty());

    }


}

#[derive(Clone)]
pub struct ReentrantDeadlockDetector<Symbol> {

    // we need a mapping of the symbols to numbers
    pub symbol_mapping : InsertionOrderMap<Symbol>,

    // now we want collections of all of the different type of facts
    pub facts : DealockPriors

}

impl <Symbol> ReentrantDeadlockDetector<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    pub fn new() -> Self {
        Self {
            symbol_mapping : InsertionOrderMap::new(),
            facts : DealockPriors::new()
        }
    }

    pub fn add_def(&mut self, var : Symbol, inst : Symbol) -> &mut Self {
        self.facts.add_def(Def(self.symbol_mapping.map(var), self.symbol_mapping.map(inst)));
        self
    }

    pub fn add_use_var(&mut self, var : Symbol, inst : Symbol) -> &mut Self {
        self.facts.add_use_var(UseVar(self.symbol_mapping.map(var), self.symbol_mapping.map(inst)));
        self
    }

    pub fn add_next(&mut self, prev : Symbol, next : Symbol) -> &mut Self {
        self.facts.add_next(Next(self.symbol_mapping.map(prev), self.symbol_mapping.map(next)));
        self
    }

}

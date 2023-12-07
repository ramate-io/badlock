use std::collections::HashSet;
use crepe::crepe;


crepe! {

    @input
    #[derive(Debug)]
    pub struct Def(pub usize, pub usize);

    @input
    #[derive(Debug)]
    pub struct UseVar(pub usize, pub usize);

    @input
    #[derive(Debug)]
    pub struct Next(pub usize, pub usize);

    @input
    #[derive(Debug)]
    pub struct Wrap(pub usize, pub usize);

    @input
    #[derive(Debug)]
    pub struct Lock(pub usize, pub usize);

    @input
    #[derive(Debug)]
    pub struct Release(pub usize, pub usize);


    @output
    #[derive(Debug)]
    pub struct Kill(pub usize, pub usize);

    @output
    #[derive(Debug)]
    pub struct In(pub usize, pub usize);

    @output
    #[derive(Debug)]
    pub struct Out(pub usize, pub usize);

    @output
    #[derive(Debug)]
    pub struct Deadlock(pub usize, pub usize, pub usize);

    @output
    #[derive(Debug)]
    pub struct Edge(pub usize, pub usize);

    @output
    #[derive(Debug)]
    pub struct Path(pub usize, pub usize);

    // Reaching definitions
    Kill(curr_inst, old_inst) <- Def(var, curr_inst), Def(var, old_inst);
    Out(inst, inst) <- Def(_, inst);
    Out(inst, def_inst) <- In(inst, def_inst), !Kill(inst, def_inst);
    In(inst, def_inst) <- Out(prev_inst, def_inst), Next(prev_inst, inst);

    // Deadlock taint
    Edge(from_inst, to_inst) <- Def(var, from_inst), UseVar(var, to_inst), In(to_inst, from_inst);
    Path(from_inst, to) <- Lock(from_inst, _), Edge(from_inst, to);
    Path(prev, next) <- Path(prev, almost), !Release(almost, _), Edge(almost, next);
    Deadlock(acquired_inst, var, reentrant_inst) <- Lock(reentrant_inst, var), Path(acquired_inst, reentrant_inst);

}

pub trait Extendable<T> {

    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
        where Iter : IntoIterator<Item = T>;

}

#[derive(Debug, Clone)]
pub struct ReentrantDeadlockPriors {
    pub defs : HashSet<Def>,
    pub use_vars : HashSet<UseVar>,
    pub nexts : HashSet<Next>,
    pub wraps : HashSet<Wrap>,
    pub locks : HashSet<Lock>,
    pub releases : HashSet<Release>
}

impl ReentrantDeadlockPriors {

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

    pub fn compute(&self) -> ReentrantDeadlockPosts {

        let mut runtime = Crepe::new();

        println!("{:?}", self);

        runtime.extend(self.defs.iter().cloned());
        runtime.extend(self.use_vars.iter().cloned());
        runtime.extend(self.nexts.iter().cloned());
        runtime.extend(self.wraps.iter().cloned());
        runtime.extend(self.locks.iter().cloned());
        runtime.extend(self.releases.iter().cloned());

        let res = runtime.run().into();

        println!("{:?}", res);

        res

    }

}

impl Extendable<Def> for ReentrantDeadlockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Def> {
        self.defs.extend(values);
        self
    }
}

impl Extendable<UseVar> for ReentrantDeadlockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = UseVar> {
        self.use_vars.extend(values);
        self
    }
}

impl Extendable<Next> for ReentrantDeadlockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Next> {
        self.nexts.extend(values);
        self
    }
}

impl Extendable<Wrap> for ReentrantDeadlockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Wrap> {
        self.wraps.extend(values);
        self
    }
}

impl Extendable<Lock> for ReentrantDeadlockPriors {
    fn extend<Iter>(&mut self, values : Iter) -> &mut Self
            where Iter : IntoIterator<Item = Lock> {
        self.locks.extend(values);
        self
    }
}

impl Extendable<Release> for ReentrantDeadlockPriors {
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

        let mut facts = ReentrantDeadlockPriors::new();
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
            Next(1, 2),
            Next(2, 3),
            Next(3, 4),
        ]);

        facts.extend(vec![
            Lock(0, 0),
            Lock(2, 0),
        ]);

        let posts = facts.compute();

        println!("{:?}", posts);

        assert_eq!(posts.deadlock.len(), 1);
        assert!(posts.deadlock.contains(&Deadlock(0, 0, 2)));

    }

    #[test]
    pub fn test_reentrant_deadlocks_simple_lock_and_release() {

        let mut facts = ReentrantDeadlockPriors::new();

        facts.extend(vec![
            Def(0xcafe, 0),
            Def(1, 1),
            Def(0xcafe, 2),
        ]);

        facts.extend(vec![
            UseVar(0xcafe, 0),
            UseVar(1, 1),
            UseVar(0xcafe, 2),
            UseVar(0xcafe, 3),
        ]);

        facts.extend(vec![
            Next(0, 1),
            Next(1, 2),
            Next(2, 3),
            Next(3, 4),
        ]);

        facts.extend(vec![
            Lock(0, 0xcafe),
            Lock(3, 0xcafe),
        ]);

        facts.extend(vec![
            Release(2, 0xcafe),
        ]);

        let posts = facts.compute();

        println!("{:?}", posts);

    }


}

#[derive(Debug, Clone)]
pub struct ReentrantDeadlockPosts {
    pub kill : HashSet<Kill>,
    pub in_ : HashSet<In>,
    pub out : HashSet<Out>,
    pub deadlock : HashSet<Deadlock>,
    pub edge : HashSet<Edge>,
    pub path : HashSet<Path>
}

impl ReentrantDeadlockPosts {

    pub fn new() -> Self {
        Self {
            kill : HashSet::new(),
            in_ : HashSet::new(),
            out : HashSet::new(),
            deadlock : HashSet::new(),
            edge : HashSet::new(),
            path : HashSet::new()
        }
    }

}

impl Into<ReentrantDeadlockPosts> for (HashSet<Kill>, HashSet<In>, HashSet<Out>, HashSet<Deadlock>, HashSet<Edge>, HashSet<Path>) {
    fn into(self) -> ReentrantDeadlockPosts {
        ReentrantDeadlockPosts {
            kill : self.0,
            in_ : self.1,
            out : self.2,
            deadlock : self.3,
            edge : self.4,
            path : self.5
        }
    }
}

pub mod generic {

    use std::collections::HashSet;

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Def<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct UseVar<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Next<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Wrap<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Lock<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Release<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Kill<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct In<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Out<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Deadlock<Symbol>(pub Symbol, pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Edge<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug, Clone, PartialEq, Eq, Hash)]
    pub struct Path<Symbol>(pub Symbol, pub Symbol);

    #[derive(Debug)]
    pub struct ReentrantDeadlockPriors<Symbol> {
        pub defs : HashSet<Def<Symbol>>,
        pub use_vars : HashSet<UseVar<Symbol>>,
        pub nexts : HashSet<Next<Symbol>>,
        pub wraps : HashSet<Wrap<Symbol>>,
        pub locks : HashSet<Lock<Symbol>>,
        pub releases : HashSet<Release<Symbol>>
    }

    impl <Symbol> ReentrantDeadlockPriors<Symbol> {

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

    }

    #[derive(Debug)]
    pub struct ReentrantDeadlockPosts<Symbol> {
        pub kill : HashSet<Kill<Symbol>>,
        pub in_ : HashSet<In<Symbol>>,
        pub out : HashSet<Out<Symbol>>,
        pub deadlock : HashSet<Deadlock<Symbol>>,
        pub edge : HashSet<Edge<Symbol>>,
        pub path : HashSet<Path<Symbol>>
    }

    impl <Symbol> ReentrantDeadlockPosts<Symbol> {

        pub fn new() -> Self {
            Self {
                kill : HashSet::new(),
                in_ : HashSet::new(),
                out : HashSet::new(),
                deadlock : HashSet::new(),
                edge : HashSet::new(),
                path : HashSet::new()
            }
        }

    }

}
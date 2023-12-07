use crate::util::insertion_order_map::InsertionOrderMap;
use super::{facts, generic::*};

#[derive(Clone, Debug)]
pub struct Program<Symbol : std::cmp::Eq + std::hash::Hash> {

    // we need a mapping of the symbols to numbers
    pub symbol_mapping : InsertionOrderMap<Symbol>,

    // now we want collections of all of the different types of facts
    priors : facts::ReentrantDeadlockPriors

}

impl <Symbol> Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    pub fn new() -> Self {
        Self {
            symbol_mapping : InsertionOrderMap::new(),
            priors : facts::ReentrantDeadlockPriors::new()
        }
    }

    pub fn priors(&self) -> ReentrantDeadlockPriors<&Symbol> {

        let mut priors = ReentrantDeadlockPriors::new();
        
       for def in self.priors.defs.iter() {
           let def = Def(
                self.symbol_mapping.unmap(def.0).unwrap(), 
                self.symbol_mapping.unmap(def.1).unwrap()
            );
            priors.defs.insert(def);
       }

        for use_var in self.priors.use_vars.iter() {
            let use_var = UseVar(
                self.symbol_mapping.unmap(use_var.0).unwrap(), 
                self.symbol_mapping.unmap(use_var.1).unwrap()
            );
            priors.use_vars.insert(use_var);
        }

        for next in self.priors.nexts.iter() {
            let next = Next(
                self.symbol_mapping.unmap(next.0).unwrap(), 
                self.symbol_mapping.unmap(next.1).unwrap()
            );
            priors.nexts.insert(next);
        }

        for wrap in self.priors.wraps.iter() {
            let wrap = Wrap(
                self.symbol_mapping.unmap(wrap.0).unwrap(), 
                self.symbol_mapping.unmap(wrap.1).unwrap()
            );
            priors.wraps.insert(wrap);
        }


       priors

    }

    pub fn compute(&self) -> ReentrantDeadlockPosts<&Symbol> {

        let inner_posts = self.priors.compute();
        let mut posts = ReentrantDeadlockPosts::new();

        for kill in inner_posts.kill.iter() {
            let kill = Kill(
                self.symbol_mapping.unmap(kill.0).unwrap(), 
                self.symbol_mapping.unmap(kill.1).unwrap()
            );
            posts.kill.insert(kill);
        }

        for in_ in inner_posts.in_.iter() {
            let in_ = In(
                self.symbol_mapping.unmap(in_.0).unwrap(), 
                self.symbol_mapping.unmap(in_.1).unwrap()
            );
            posts.in_.insert(in_);
        }

        for out in inner_posts.out.iter() {
            let out = Out(
                self.symbol_mapping.unmap(out.0).unwrap(), 
                self.symbol_mapping.unmap(out.1).unwrap()
            );
            posts.out.insert(out);
        }

        for deadlock in inner_posts.deadlock.iter() {
            let deadlock = Deadlock(
                self.symbol_mapping.unmap(deadlock.0).unwrap(), 
                self.symbol_mapping.unmap(deadlock.1).unwrap(),
                self.symbol_mapping.unmap(deadlock.2).unwrap()
            );
            posts.deadlock.insert(deadlock);
        }

        for edge in inner_posts.edge.iter() {
            let edge = Edge(
                self.symbol_mapping.unmap(edge.0).unwrap(), 
                self.symbol_mapping.unmap(edge.1).unwrap()
            );
            posts.edge.insert(edge);
        }

        for path in inner_posts.path.iter() {
            let path = Path(
                self.symbol_mapping.unmap(path.0).unwrap(), 
                self.symbol_mapping.unmap(path.1).unwrap()
            );
            posts.path.insert(path);
        }

        posts

    }

}

impl <Symbol> facts::Extendable<Def<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = Def<Symbol>>
    {

        for def in iter.into_iter() {
            let def = facts::Def(
                self.symbol_mapping.map(def.0), 
                self.symbol_mapping.map(def.1)
            );
            self.priors.defs.insert(def);
        }
        self
    }

}

impl <Symbol> facts::Extendable<UseVar<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = UseVar<Symbol>>
    {

        for use_var in iter.into_iter() {
            let use_var = facts::UseVar(
                self.symbol_mapping.map(use_var.0), 
                self.symbol_mapping.map(use_var.1)
            );
            self.priors.use_vars.insert(use_var);
        }
        self
    }

}

impl <Symbol> facts::Extendable<Next<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = Next<Symbol>>
    {

        for next in iter.into_iter() {
            let next = facts::Next(
                self.symbol_mapping.map(next.0), 
                self.symbol_mapping.map(next.1)
            );
            self.priors.nexts.insert(next);
        }
        self
    }

}

impl <Symbol> facts::Extendable<Wrap<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = Wrap<Symbol>>
    {

        for wrap in iter.into_iter() {
            let wrap = facts::Wrap(
                self.symbol_mapping.map(wrap.0), 
                self.symbol_mapping.map(wrap.1)
            );
            self.priors.wraps.insert(wrap);
        }
        self
    }

}

impl <Symbol> facts::Extendable<Lock<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = Lock<Symbol>>
    {

        for lock in iter.into_iter() {
            let lock = facts::Lock(
                self.symbol_mapping.map(lock.0), 
                self.symbol_mapping.map(lock.1)
            );
            self.priors.locks.insert(lock);
        }
        self
    }

}

impl <Symbol> facts::Extendable<Release<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, iter : Iter) -> &mut Self
        where 
            Iter : IntoIterator<Item = Release<Symbol>>
    {

        for release in iter.into_iter() {
            let release = facts::Release(
                self.symbol_mapping.map(release.0), 
                self.symbol_mapping.map(release.1)
            );
            self.priors.releases.insert(release);
        }
        self
    }

}

pub mod test {

    use facts::Extendable;

    use super::*;

    #[derive(Clone, Debug, PartialEq, Eq, Hash)]
    pub struct MySymbol(String);

    #[test]
    fn test_maps_and_unmaps() {

        let mut program : Program<MySymbol> = Program::new();

        program.extend(vec![
            Def(MySymbol("x".to_string()), MySymbol("inst-0".to_string())),
            Def(MySymbol("y".to_string()), MySymbol("inst-1".to_string())),
            Def(MySymbol("x".to_string()), MySymbol("inst-2".to_string())),
        ]);

        program.extend(vec![
            UseVar(MySymbol("x".to_string()), MySymbol("inst-0".to_string())),
            UseVar(MySymbol("y".to_string()), MySymbol("inst-1".to_string())),
            UseVar(MySymbol("x".to_string()), MySymbol("inst-2".to_string())),
            UseVar(MySymbol("x".to_string()), MySymbol("inst-3".to_string())),
        ]);

        program.extend(vec![
            Next(MySymbol("inst-0".to_string()), MySymbol("inst-1".to_string())),
            Next(MySymbol("inst-1".to_string()), MySymbol("inst-2".to_string())),
            Next(MySymbol("inst-2".to_string()), MySymbol("inst-3".to_string())),
            Next(MySymbol("inst-3".to_string()), MySymbol("inst-4".to_string()))
        ]);

        program.extend(vec![
            Lock(MySymbol("inst-0".to_string()), MySymbol("x".to_string())),
            Lock(MySymbol("inst-2".to_string()), MySymbol("x".to_string())),
        ]);

        let posts = program.compute();

        println!("{:#?}", posts);

        let inst_0 = MySymbol("inst-0".to_string());
        let x =  MySymbol("x".to_string());
        let inst_2 = MySymbol("inst-2".to_string());

        let expected_deadlock = Deadlock(&inst_0, &x, &inst_2);
        assert!(posts.deadlock.contains(
            &expected_deadlock
        ));


    }


}
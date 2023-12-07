use crate::util::insertion_order_map::InsertionOrderMap;
use super::{facts, Def};

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

    pub fn priors(&self) -> facts::generic::ReentrantDeadlockPriors<&Symbol> {

        let mut priors = facts::generic::ReentrantDeadlockPriors::new();
        
       for def in self.priors.defs.iter() {
           let def = facts::generic::Def(
                self.symbol_mapping.unmap(def.0).unwrap(), 
                self.symbol_mapping.unmap(def.1).unwrap()
            );
            priors.defs.insert(def);
       }

        for use_var in self.priors.use_vars.iter() {
            let use_var = facts::generic::UseVar(
                self.symbol_mapping.unmap(use_var.0).unwrap(), 
                self.symbol_mapping.unmap(use_var.1).unwrap()
            );
            priors.use_vars.insert(use_var);
        }

        for next in self.priors.nexts.iter() {
            let next = facts::generic::Next(
                self.symbol_mapping.unmap(next.0).unwrap(), 
                self.symbol_mapping.unmap(next.1).unwrap()
            );
            priors.nexts.insert(next);
        }

        for wrap in self.priors.wraps.iter() {
            let wrap = facts::generic::Wrap(
                self.symbol_mapping.unmap(wrap.0).unwrap(), 
                self.symbol_mapping.unmap(wrap.1).unwrap()
            );
            priors.wraps.insert(wrap);
        }


       priors

    }

    pub fn compute(&self) -> facts::generic::ReentrantDeadlockPosts<&Symbol> {

        let inner_posts = self.priors.compute();
        let mut posts = facts::generic::ReentrantDeadlockPosts::new();

        for kill in inner_posts.kill.iter() {
            let kill = facts::generic::Kill(
                self.symbol_mapping.unmap(kill.0).unwrap(), 
                self.symbol_mapping.unmap(kill.1).unwrap()
            );
            posts.kill.insert(kill);
        }

        for in_ in inner_posts.in_.iter() {
            let in_ = facts::generic::In(
                self.symbol_mapping.unmap(in_.0).unwrap(), 
                self.symbol_mapping.unmap(in_.1).unwrap()
            );
            posts.in_.insert(in_);
        }

        for out in inner_posts.out.iter() {
            let out = facts::generic::Out(
                self.symbol_mapping.unmap(out.0).unwrap(), 
                self.symbol_mapping.unmap(out.1).unwrap()
            );
            posts.out.insert(out);
        }

        for deadlock in inner_posts.deadlock.iter() {
            let deadlock = facts::generic::Deadlock(
                self.symbol_mapping.unmap(deadlock.0).unwrap(), 
                self.symbol_mapping.unmap(deadlock.1).unwrap()
            );
            posts.deadlock.insert(deadlock);
        }

        for edge in inner_posts.edge.iter() {
            let edge = facts::generic::Edge(
                self.symbol_mapping.unmap(edge.0).unwrap(), 
                self.symbol_mapping.unmap(edge.1).unwrap()
            );
            posts.edge.insert(edge);
        }

        for path in inner_posts.path.iter() {
            let path = facts::generic::Path(
                self.symbol_mapping.unmap(path.0).unwrap(), 
                self.symbol_mapping.unmap(path.1).unwrap()
            );
            posts.path.insert(path);
        }

        posts

    }

}

impl <Symbol> facts::Extendable<facts::generic::Def<Symbol>> for Program<Symbol>
    where 
        Symbol : std::cmp::Eq + std::hash::Hash + Clone
{

    fn extend<Iter>(&mut self, def : Iter) 
        where 
            Iter : IntoIterator<Item = facts::generic::Def<Symbol>>
    {
        let def = facts::Def(
            self.symbol_mapping.map(def.0), 
            self.symbol_mapping.map(def.1)
        );
        self.priors.defs.insert(def);
    }

}

pub mod test {

    use super::*;

    #[derive(Clone, Debug, PartialEq, Eq, Hash)]
    pub struct MySymbol(String);

    #[test]
    fn test_maps_and_unmaps() {

        let mut program : Program<MySymbol> = Program::new();


    }


}
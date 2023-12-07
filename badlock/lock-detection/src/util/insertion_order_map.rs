use bimap::BiMap;

#[derive(Clone, Debug)]
pub struct InsertionOrderMap<Value : std::cmp::Eq + std::hash::Hash> {
    pub mapping : BiMap<Value, usize>
}

impl <Value> InsertionOrderMap<Value> 
where 
    Value : std::cmp::Eq + std::hash::Hash
{

    pub fn new() -> Self {
        Self {
            mapping : BiMap::new()
        }
    }

    pub fn map(&mut self, value : Value) -> usize {

        match self.mapping.get_by_left(&value) {
            Some(index) => return index.clone(),
            None => {
                let index = self.mapping.len();
                self.mapping.insert(value, index.clone());
                return index;
            }
        }

    }

    pub fn unmap(&self, index : usize) -> Option<&Value> {
        self.mapping.get_by_right(&index)
    }

}

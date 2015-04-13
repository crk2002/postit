module Sluggable
  
  def add_slug(field)
    self.slug = field.parameterize
    count=1
    obj=self.class.find_by slug: self.slug
    while obj
      count +=1
      obj=self.class.find_by slug: self.slug + "-" + count.to_s
    end
    self.slug = self.slug + "-" + count.to_s if count > 1
  end
  
  def to_param
    slug
  end
  
end
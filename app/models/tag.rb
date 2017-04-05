require 'data_mapper'
require 'dm-postgres-adapter'

class Tag

  include DataMapper::Resource

  property :id, Serial
  property :tag_name, String

end


class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = :foo
  attr_accessor :type
end

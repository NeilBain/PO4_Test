class Task < ActiveRecord::Base
  validates :name, :presence => true
  validates :lower,  :presence => true, :numericality => {:greater_than => 0}
  validates :upper,  :presence => true, :numericality => {:greater_than_or_equal_to => :lower}
  belongs_to :projects
  has_many :subtasks, :class_name => "Task", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_task, :class_name => "Task", :foreign_key => "parent_id"
  
  after_validation :set_risk, on: [:create, :update]
  
  protected
  def set_risk
    self.error = ((self.upper-self.lower)/2)*((self.upper-self.lower)/2)
  end
  
  
end

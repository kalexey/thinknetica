# frozen_string_literal: true

module InstanceCounter
  # included callback
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  # в принципе метод показывает сколько раз 
  # создавали инстансы класса, а не сколько инстансов объектов существует
  
  module InstanceMethods
    private

    def register_instance
      self.class.instances = 0 if self.class.instances.nil?
      self.class.instances += 1
    end
  end
end

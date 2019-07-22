# frozen_string_literal: true

module InstanceCounter
  # included callback
  def self.included(base)
    base.extend ClassMethods
    base.instances = 0 unless base.instance_variable_defined?(:@instances)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

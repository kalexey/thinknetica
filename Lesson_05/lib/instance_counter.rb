# frozen_string_literal: true

module InstanceCounter
  # included callback
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances = 0 unless instance_variable_defined?(:@instances)
      @instances
    end

    def instances=(num)
      @instances = num
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

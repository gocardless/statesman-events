module Statesman
  class EventTransitions
    attr_reader :machine, :event_name

    def initialize(machine, event_name, &block)
      @machine    = machine
      @event_name = event_name
      instance_eval(&block)
    end

    def transition(from: nil, to: nil)
      from = to_s_or_nil(from)
      to = array_to_s_or_nil(to)

      machine.transition(from: from, to: to)

      machine.events[event_name] ||= {}
      machine.events[event_name][from] ||= []
      machine.events[event_name][from] += to
    end

    private

    def to_s_or_nil(input)
      input.nil? ? input : input.to_s
    end

    def array_to_s_or_nil(input)
      Array(input).map { |item| to_s_or_nil(item) }
    end
  end
end

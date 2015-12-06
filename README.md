# Statesman Events

Event support for [Statesman](https://github.com/gocardless/statesman).

[![Gem Version](https://badge.fury.io/rb/statesman-events.png)](http://badge.fury.io/rb/statesman-events)
[![Build Status](https://travis-ci.org/gocardless/statesman-events.svg?branch=master)](https://travis-ci.org/gocardless/statesman-events)

---

## Installation

```ruby
gem install statesman-events
```

## TL;DR Usage

```ruby
class TaskStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :unstarted, initial: true
  state :started
  state :finished
  state :cancelled

  event :start do
    transition from: :unstarted,  to: :started
  end

  event :finish do
    transition from: :started,    to: :finished
  end

  event :cancel do
    transition from: :unstarted,  to: :cancelled
    transition from: :started,    to: :cancelled
  end

  event :restart do
    transition from: :finished,   to: :started
    transition from: :cancelled,  to: :started
  end
end

class Task < ActiveRecord::Base
  delegate :current_state, :trigger, :available_events, to: :state_machine

  def state_machine
    @state_machine ||= TaskStateMachine.new(self)
  end
end

task = Task.new

task.current_state          # => "unstarted"
task.trigger(:start)        # => true/false
task.current_state          # => "started"
task.available_events       # => [:finish, :cancel]
```

## Class methods

#### `Events.event`
```ruby
ExampleMachine.event(:some_event) do
  transition from: :some_state,       to: :another_state
  transition from: :some_other_state, to: :yet_another_state
end
```
Define an event rule. When triggered, the first available transition from the
current state will be called.

## Instance methods

#### `Event#trigger`
```ruby
instance.trigger(:some_event)
```
Triggers the passed event, returning `true` on success. Returns false on
failure.

#### `Event#trigger!`
```ruby
instance.trigger(:some_event)
```
Triggers the passed event, returning `true` on success. Raises
`Statesman::GuardFailedError` or `Statesman::TransitionFailedError` on failure.

#### `Event#available_events`
```ruby
instance.available_events
```
Returns an array of events you can `trigger` from the current state.

---

GoCardless ♥ open source. If you do too, come [join us](https://gocardless.com/jobs#software-engineer).

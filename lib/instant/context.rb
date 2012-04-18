module Instant
  class Context
    def log_assign(name, value)
      return value
    end

    def loop_begin()
    end

    def loop_inside_begin
    end

    def loop_inside_end
    end

    def loop_end
    end

    def get_binding
      binding()
    end
  end
end
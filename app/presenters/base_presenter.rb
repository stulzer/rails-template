class BasePresenter
  def initalize(object, template)
    @object = object
    @template = template
  end

private

  def self.presents(name)
    define_method(name) do
      @object
    end
  end
  # usage => presents :name

  def h
    @template
  end
end

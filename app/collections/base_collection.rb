# frozen_string_literal: true

# BaseCollection is inherited by all other collections. It ensures all
# filters are applied to the collection.
class BaseCollection
  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      paginate
    end
  end

  private

  # ensure_filters will only lookup for those methods who starts with filter_by_
  def ensure_filters
    # private_methods returns the list of private methods accessible to obj. If the all parameter is set to
    # false, only those methods in the receiver will be listed.
    private_methods(false).grep(/\Afilter_by_/)&.each do |filter|
      send(filter)
    end
  end

  def filter
    @relation = yield(@relation)
  end

  def paginate
    return @relation unless params[:page]

    @relation.page(params[:page]).per(params[:per_page])
  end
end

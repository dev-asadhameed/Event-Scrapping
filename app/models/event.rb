class Event < ApplicationRecord
  TYPES = %w[CoBerlin VisitBerlin]
  validates :name, :type, presence: true
  validates :type, inclusion: { in: TYPES }

  scope :search_by_name, ->(query_str) { where("name ILIKE '%#{query_str}%'") }
  scope :search_by_site, ->(query_str) { where("type ILIKE '%#{query_str}%'") }
  scope :search_by_date, lambda { |query_str|
                           where(end_date: query_str.beginning_of_day..query_str.end_of_day).or(where(start_date:
                           query_str.beginning_of_day..query_str.end_of_day))
                         }
  scope :search_by_name_site, ->(query_str) { search_by_name(query_str).or(search_by_site(query_str)) }
  scope :search_by_name_date_site, lambda { |query_str|
                                     search_by_name(query_str).or(search_by_site(query_str)).or(search_by_date(query_str))
                                   }
end

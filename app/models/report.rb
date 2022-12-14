class Report < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_rich_text :what_is_done
  has_rich_text :plan_for_next_day

  validates :what_is_done, presence: true
  validates :plan_for_next_day, presence: true

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_country_id,
      :with_created_at_gte
    ]
  )

  scope :sorted_by, (lambda do |sort_option|

    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  
    case sort_option.to_s
    when /^created_at_/
      order("reports.created_at #{ direction }")
    when /^name_/
      order("reports.name #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  end)
end

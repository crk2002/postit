module Voteable
  
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :voteable
  end
  
  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
  
end

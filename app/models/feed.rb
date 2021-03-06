require 'action_controller'

class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :items, :through => :feeds_items
  
  has_many :feed_subscriptions, :dependent => :destroy

  def subscribe_user(user, is_caught_up = false)
    subscription = FeedSubscription.find(:first, :conditions => ["feed_id = ? and user_id = ?", self.id, user.id])
    unless subscription.nil?
      if (is_caught_up == false)
        subscription.caught_up = is_caught_up
        subscription.save rescue true
      end
      # already subscribed
      return true
    end
    
    subscription = FeedSubscription.new
    subscription.feed = self
    subscription.user = user
    subscription.send_email = true
    subscription.caught_up = is_caught_up
    subscription.save rescue true
  end

  # Returns a FeedSubscirption object if the specified user is subscribed to this feed, otherwise nil.
  def get_subscription(user)
    FeedSubscription.find(:first, :conditions => ["feed_id = ? and user_id = ?", self.id, user.id])
  end

  # Gets one page of items for this feed
  def load_items(user, limit = 25, page = 1)
    pages = ActionController::Base::Paginator.new(self, FeedsItems.count(:conditions => ["feed_id = ?", self.id]), limit, page)
    items = FeedsItems.find(:all, :conditions => ['feed_id = ?', self.id], :order => 'timestamp DESC, item_id DESC', :limit => limit, :offset => pages.current.offset)
    items = FeedsItems.apply_acls(items, user)
    return pages, items
  end
  
  def validate
    # Ensure that a feed is only for a course, or only for a user, not both or neither.
    if self.user_id.nil? && self.course_id.nil?
      errors.add_to_base( 'A feed must be assoficated with a user or a course.' )
    elsif self.user_id.nil? == self.course_id.nil?
      errors.add_to_base( 'A feed can only be for a course or a user' )
    end
  end  
end

class CommentObserver <  ActiveRecord::Observer 
  def after_create(comment)  
    FeedbackMailer.deliver_feedback_notification(comment) unless comment.comments.empty?
  end
end

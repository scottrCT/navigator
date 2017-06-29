class FeedbackMailer < ActionMailer::Base
   def feedback_notification(comment)
     recipients   "NavFeedback@ctunitedway.org"
     from         "feedback@211Navigator.org"
     subject      "211 Navigator Feedback"
     content_type "text/html" 
     body         :comment => comment
     sent_on      Time.now
   end
end

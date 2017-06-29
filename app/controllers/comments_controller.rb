class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :partial=>"new", :layout=>"application"
  end
  def create
    @comment = Comment.new(params[:comment])
    @comment.ip_addr = request.remote_ip
    if verify_recaptcha(:model=>@comment, :message=>'Your typed words did not match the image, try again.') && @comment.save 
        logger.info "Saved Comment.  Email sent.";
        render :partial=>"show"
    else
        logger.error "=========Failed to send feedback for some reason=========";
        render :partial=>"new", :locals=>{:comment=>@comment}
    end
  end
  def show
    
  end
end

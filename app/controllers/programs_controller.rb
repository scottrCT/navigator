class ProgramsController < ApplicationController
  def index
    @programs = Program.find(:all, :order=>"name")
  end
  
  def redirect
    @link = ProgramLink.find_by_id(params[:id])
    logger.debug "Found link #{@link.id}"
    @track = LinkTracker.new
    @track.link = @link.id
    @track.survey = params[:survey]
    @track.ip_addr = request.remote_ip
    @track.save
    redirect_to @link.link
  end
end

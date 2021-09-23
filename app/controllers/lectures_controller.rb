class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[ show edit update destroy ]
  before_action :authenticate_super_admin!
  load_and_authorize_resource


  # GET /lectures or /lectures.json
  def index
  end

  # GET /lectures/1 or /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture.lecture_contents.build
  end

  # GET /lectures/1/edit
  def edit
    # @lecture.lecture_contents.build
  end

  # POST /lectures or /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lectures_path, notice: "Lecture was successfully created." }
        format.json { render :show, status: :created, location: @lecture }
      else
        flash[:notice] = @lecture.errors.messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1 or /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to edit_lecture_path(@lecture), notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1 or /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: "Lecture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lecture_params
      params.require(:lecture).permit(:subject ,:title ,:super_admin_id , 
          lecture_contents_attributes: [ :id, :lecture_id, :desciption ,:content , :_destroy ])
    end
end

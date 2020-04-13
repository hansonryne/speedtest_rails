class SpeedTestsController < ApplicationController
  before_action :set_speed_test, only: [:show, :edit, :update, :destroy]

  # GET /speed_tests
  # GET /speed_tests.json
  def index
    @speed_tests = SpeedTest.all.sort_by(&:created_at).to_a
    @pings = SpeedTest.get_pings(@speed_tests)
    @download_speeds = SpeedTest.get_download_speed(@speed_tests)
    @upload_speeds = SpeedTest.get_upload_speed(@speed_tests)
  end

  # GET /speed_tests/1
  # GET /speed_tests/1.json
  def show
  end

  # GET /speed_tests/new
  def new
    @speed_test = SpeedTest.new
  end

  # GET /speed_tests/1/edit
  def edit
  end

  # POST /speed_tests
  # POST /speed_tests.json
  def create
    @speed_test = SpeedTest.new(speed_test_params)

    respond_to do |format|
      if @speed_test.save
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully created.' }
        format.json { render :show, status: :created, location: @speed_test }
      else
        format.html { render :new }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speed_tests/1
  # PATCH/PUT /speed_tests/1.json
  def update
    respond_to do |format|
      if @speed_test.update(speed_test_params)
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully updated.' }
        format.json { render :show, status: :ok, location: @speed_test }
      else
        format.html { render :edit }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speed_tests/1
  # DELETE /speed_tests/1.json
  def destroy
    @speed_test.destroy
    respond_to do |format|
      format.html { redirect_to speed_tests_url, notice: 'Speed test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speed_test
      @speed_test = SpeedTest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def speed_test_params
      params.require(:speed_test).permit(:ping, :upload, :download, :server)
    end
end

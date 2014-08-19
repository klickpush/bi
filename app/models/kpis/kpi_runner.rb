class KpiRunner
  def initialize(date, rerun = false)
    @date = date
    @rerun = rerun
  end

  def run_kpis
    add_db_kpis
    # add_performance_kpis
  end

  # Custom work from the original team: https://github.com/paperlesspost/bi/issues/13
  # def add_performance_kpis
  #   PerformanceKpis.new.create_kpi_performance_results unless @rerun
  # end

  def add_db_kpis
    Kpi.active.each do |k|
      begin
        start = Time.now
        print k.name
        k.calculate!(@date)
        print " - #{start - Time.now}\n"
      rescue
        print k.name
        print " - ERROR!!! -\n"
      end
    end
  end

  def deliver_daily_report
    KpiMailer.kpi_daily_report(@date).deliver
  end
end

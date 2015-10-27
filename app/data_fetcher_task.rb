class DataFetcherTask < Java::Util::TimerTask
  attr_accessor :context
  def run
    intent = Android::Content::Intent.new(context, DataFetcher)
    context.startService(intent)
    context = nil
  end
end

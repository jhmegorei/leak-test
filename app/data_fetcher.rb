class DataFetcher < Android::App::IntentService
  include DebugUtils
  def onHandleIntent(intent)
    broadcast
  end

  def broadcast
    intent = Android::Content::Intent.new("UPDATE_LIST")
    Android::Support::V4::Content::LocalBroadcastManager.getInstance(self).sendBroadcast(intent)
    debug "sent broadcast"
  end

  def onDestroy
    super
    debug "destroying DataFetcher"
  end
end

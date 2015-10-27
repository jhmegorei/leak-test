class MainActivity < Android::App::Activity
  include DebugUtils
  def onCreate(savedInstanceState)
    super
    register_broadcast_receiver
    setContentView(R::Layout::Main_layout)
    list = findViewById(R::Id::Items)

    list.adapter = list_adapter
  end

  def list_adapter
    ItemsAdapter.new(
      self,
      items_cursor,
      0
    )
  end

  def items_cursor
    ItemDatabaseHelper.getInstance.all
  end

  def update_list
    list = findViewById(R::Id::Items)
    list.adapter.changeCursor(items_cursor)
  end

  def register_broadcast_receiver
    @receiver = UpdateReceiver.new
    @receiver.code_to_run = lambda { update_list }
    filter = Android::Content::IntentFilter.new("UPDATE_LIST")
    Android::Support::V4::Content::LocalBroadcastManager.getInstance(self).registerReceiver(@receiver, filter)
  end

  def unregister_broadcast_receiver
    unregisterReceiver(@receiver)
  end

  def onDestroy
    super
    unregister_broadcast_receiver
  end

  class UpdateReceiver < Android::Content::BroadcastReceiver
    include DebugUtils
    attr_accessor :code_to_run
    def onReceive(context, intent)
      # do nothing
      debug "received intent"
      code_to_run.run
    end
  end
end

class LeakTest < Android::App::Application

  def onCreate
    super
    ItemDatabaseHelper.setInstance(self)
    insert_items if ItemDatabaseHelper.getInstance.all.count == 0
    start_data_fetcher
  end

  def start_data_fetcher
    t = Java::Util::Timer.new('DataFetcher')
    task = DataFetcherTask.new
    task.context = self
    t.scheduleAtFixedRate(task, 0, 1000)
  end

  def insert_items
    i1 = Item.new
    i2 = Item.new
    i1.id = 'ID 1'
    i1.title = 'Item 1'
    i2.id = 'ID 2'
    i2.title = 'Item 2'

    db = ItemDatabaseHelper.getInstance
    db.save(i1)
    db.save(i2)
  end

end

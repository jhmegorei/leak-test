class ItemDatabaseHelper < Android::Database::Sqlite::SQLiteOpenHelper
  include DebugUtils

  DB_NAME = 'items.sqlite'
  VERSION = 1
  TABLE_NAME = 'items'
  COLUMN_ID = '_id'
  COLUMN_TITLE = 'title'

  def self.setInstance(context)
    @@instance ||= new(context, DB_NAME, nil, VERSION)
  end

  def self.getInstance
    @@instance
  end

  def db
    @db ||= getWritableDatabase
  end

  def save_hash(hash)
    cv = Android::Content::ContentValues.new
    cv.put(COLUMN_ID, hash["id"]) if hash["id"] != nil
    cv.put(COLUMN_TITLE, hash["title"])

    row_id = hash["id"] == nil ? db.insertOrThrow(TABLE_NAME, nil, cv) : db.replaceOrThrow(TABLE_NAME, nil, cv)
    row_id
  end

  def save(item)
    cv = Android::Content::ContentValues.new
    cv.put(COLUMN_ID, item.id) if item.id != nil
    cv.put(COLUMN_TITLE, item.title)

    row_id = item.id == nil ? db.insertOrThrow(TABLE_NAME, nil, cv) : db.replaceOrThrow(TABLE_NAME, nil, cv)
    row_id
  end

  def all
    db = getReadableDatabase()
    data = db.query(
      TABLE_NAME,
      nil, # columns as string array
      nil, # selection (where clause without WHERE)
      nil, # selection arguments (String array with values for ? placeholders in selection)
      nil, # group by
      nil, # having
      "#{COLUMN_TITLE} ASC"
    )
    ItemCursor.new(data)
  end

  class ItemCursor < Android::Database::CursorWrapper
    include DebugUtils
    def to_item
      return nil if outOfBounds?
      Item.new.tap do |i|
        i.id = getString(getColumnIndex(COLUMN_ID))
        i.title = getString(getColumnIndex(COLUMN_TITLE))
      end
    end

    def outOfBounds?
      isBeforeFirst() || isAfterLast()
    end
  end

  private

  def onCreate(database)
    create_query =  "CREATE TABLE #{TABLE_NAME} ("
    create_query << "#{COLUMN_ID} varchar(36) primary key, "
    create_query << "#{COLUMN_TITLE} varchar(100)"
    create_query << ")"

    database.execSQL(create_query)
  end

  def onUpgrade(database, old_version, new_version)
    # do schema migrations here
  end
end

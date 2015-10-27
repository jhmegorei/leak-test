class ItemsAdapter < Android::Widget::CursorAdapter
  include DebugUtils

  def newView(context, cursor, parent)
    Android::View::LayoutInflater.from(context).inflate(R::Layout::Item_cell, parent, false)
  end

  def bindView(view, context, cursor)
    item = cursor.to_item
    name_field = view.findViewById(R::Id::Name)
    name_field.text = item.title
    item = nil
  end
end

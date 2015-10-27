module DebugUtils
  def debug(message)
    Android::Util::Log.d("====== #{Java::Lang::System.currentTimeMillis.toString}: #{getClass.getSimpleName} - ", message)
  end
end

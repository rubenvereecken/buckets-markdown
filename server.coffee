# I'm very much tempted to try an approach like
# bkts.registerFieldTypeMiddleware ...
# But not entirely sure yet how to go about this

marked = require 'marked'

module.exports = (config) ->
  {_} = config

  middleware:
    fieldType: # fieldTypes need special love, generic middleware should be possible too
      markdown:
        preOrPost: 'pre' # or 'post'
        action: 'save' # any of 'init', 'save', 'validate'
        callback: (doc, fields, next) ->
          content = doc.get 'content'
          for field in fields
            fieldSlug = field.slug
            doc.set "content.#{fieldSlug}_html", marked doc.get "content.#{fieldSlug}"
          next()

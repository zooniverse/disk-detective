AppView = require('views/app_view')
Router = require('lib/router')
enUS = require('lib/en-us')

module.exports = ->
  t7e.load(enUS)

  languageManager = new zooniverse.LanguageManager({
    translations: {
      en: { label: "English", strings: enUS }
      es: { label: "Español", strings: "./translations/es.json" }
      fr: { label: "Français", strings: "./translations/fr.json" }
      de: { label: "Deutsch", strings: "./translations/de.json" }
      it: { label: "Italiano", strings: "./translations/it.json" }
      ru: { label: "русский", strings: "./translations/ru.json" }
      pl: { label: 'Polski', strings: './translations/pl.json' }
      pt: { label: 'Português', strings: './translations/pt.json' }
      ro: { label: "Româna", strings: "./translations/ro.json" }
      hu: { label: "Magyar", strings: "./translations/hu.json" }
      id: { label: "Bahasa Indonesia", strings: "./translations/id.json" }
      zh_cn: { label: "简体中文", strings: "./translations/zh-cn.json" }
      zh_tw: { label: "繁體中文", strings: "./translations/zh-tw.json" }
      ja: { label: "日本語", strings: "./translations/ja.json" }
    }
  })

  languageManager.on('change-language', (e, code, languageStrings) ->
    t7e.load(languageStrings)
    t7e.refresh()
  )

  api = if window.location.hostname is 'www.diskdetective.org'
    new zooniverse.Api project: 'wise', host: 'https://www.diskdetective.org', path: '/_ouroboros_api/proxy'
  else
    new zooniverse.Api project: 'wise'

  ga = new zooniverse.GoogleAnalytics({account: 'UA-1224199-50'})

  topBar = new zooniverse.controllers.TopBar()
  topBar.el.appendTo(document.body)

  zooniverse.models.User.fetch()

  appView = new AppView()
  router = new Router(appView)

  Backbone.history.start()

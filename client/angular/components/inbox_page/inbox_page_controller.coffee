AppConfig      = require 'shared/services/app_config.coffee'
Session        = require 'shared/services/session.coffee'
Records        = require 'shared/services/records.coffee'
InboxService   = require 'shared/services/inbox_service.coffee'

angular.module('loomioApp').controller 'InboxPageController', ($scope, $rootScope, LoadingService, ModalService, GroupModal) ->
  $rootScope.$broadcast('currentComponent', {titleKey: 'inbox_page.unread_threads' ,page: 'inboxPage'})
  $rootScope.$broadcast('setTitle', 'Inbox')
  $rootScope.$broadcast('analyticsClearGroup')
  InboxService.load()

  @threadLimit = 50
  @views = InboxService.queryByGroup()

  @groups = ->
    Records.groups.find(_.keys(@views))

  @hasThreads = ->
    InboxService.unreadCount() > 0

  @noGroups = ->
    !Session.user().hasAnyGroups()

  @startGroup = ->
    ModalService.open GroupModal, group: -> Records.groups.build()

  return

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  class TaskViewModel
    constructor: () ->
      @tasks   = ko.observableArray()
      @newTask = ko.observable()
      $.getJSON "tasks.json", @tasks

    createTask: () =>
      # create a task json string to send to the server
      task =
        task:
          content: @newTask()

      # reset the old task
      @newTask ""

      $.post "tasks.json", task, (data) =>
        # add the created task to the array
        @tasks.push data

    destroy: (task) =>
      @tasks.remove task
      $.ajax
        url: "tasks/#{task.id}.json"
        type: "delete"
        error: () =>
          @tasks.push task

  ko.applyBindings new TaskViewModel
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Task
  constructor: (id, content, done) ->
    @id = id
    @content = ko.observable(content)
    @done = ko.observable(done)
    @editMode = ko.observable(false)

  toggleEdit: () ->
    @editMode(!@editMode())

  action: () ->
    @save() if @editMode()
    @toggleEdit()

  save: () ->
    $.ajax
      url: "tasks/#{@id}.json"
      data:
        task:
          content: @content()
          done: @done()
      type: "put"

jQuery ->
  class TaskViewModel
    constructor: () ->
      @tasks   = ko.observableArray()
      @newTask = ko.observable()
      $.getJSON "tasks.json", (json) =>
        for task in json
          @tasks.push new Task(task.id, task.content, task.done)

    createTask: () =>
      # create a task json string to send to the server
      task =
        task:
          content: @newTask()

      # reset the old task
      @newTask ""

      $.post "tasks.json", task, (data) =>
        # add the created task to the array
        task = new Task(data.id, data.content, data.done)
        @tasks.push task

    destroy: (task) =>
      @tasks.remove task
      $.ajax
        url: "tasks/#{task.id}.json"
        type: "delete"
        error: () =>
          @tasks.push task

  ko.applyBindings new TaskViewModel

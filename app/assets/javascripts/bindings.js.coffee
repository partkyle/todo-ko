ko.bindingHandlers.editableTask =
  init: (element, valueAccessor) ->
    taskInput = $('<input>').attr
      "type": "text"
      "data-bind": "value: content, visible: editMode()"
    taskDisplay = $('<span>').attr
      "data-bind": "text: content, visible: editMode() === false"
    button = $('<button>Edit</button>').addClass('btn').attr
      "data-bind": "click: action, text: editMode() ? 'Save' : 'Edit'"
    $(element).append(taskInput).append(taskDisplay).append(button).attr
      "data-bind": "editableTask: true, click: toggleEdit"
  update: (element, valueAccessor) ->

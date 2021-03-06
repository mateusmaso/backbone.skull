View = require "./view"
TodosView = require "./todos_view"
Todo = require "../models/todo"

module.exports = class RootView extends View

  templateName: "/root"

  elements:
    newTodo: ".new-todo"
    toggleAll: ".toggle-all"
    clearCompleted: ".clear-completed"

  events:
    "keypress newTodo": "addTodo"
    "click toggleAll": "toggleAll"
    "click clearCompleted": "clearCompleted"

  defaults:
    toggleAll: false

  initialize: ->
    @listenTo(@get("todos"), "update", @update)
    @listenTo(@get("todos"), "change:completed", @update)

  context: ->
    todos: @get("todos")
    leftCount: @get("todos").left().length
    completedCount: @get("todos").completed().length

  addTodo: (event) ->
    return if event.keyCode isnt 13
    text = @$("newTodo").val()

    if text.trim() isnt ""
      @$("newTodo").val("")
      @get("todos").add(new Todo(text: text))

  toggleAll: ->
    todo.set(completed: not @get("toggleAll")) for todo in @get("todos").models
    @set("toggleAll", not @get("toggleAll"))

  clearCompleted: ->
    toDestroy = []
    toDestroy.push(todo) for todo in @get("todos").models when todo.get("completed")
    todo.destroy() for todo in toDestroy

  @register "RootView"

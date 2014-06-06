Hipbone.Validation =

  initializeValidation: (validations={}) ->
    @errors = []
    @validations = _.extend({}, @validations, validations)

  hasErrors: ->
    @errors.length > 0

  validate: (attributes={}) ->
    @errors = []
    for attribute, value of attributes
      validation = @validations[attribute]
      if validation and not validation.apply(this, [value, attributes])
        @errors.push(attribute)
    @errors if @hasErrors()

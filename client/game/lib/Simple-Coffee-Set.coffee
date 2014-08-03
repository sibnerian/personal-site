class Set
    constructor: (hashFunction) ->
        @_hashFunction = hashFunction or (val) ->
            #assuming val is an object by default
            if not val._id?
                val._id = _.uniqueId()
            val._id
        @_values = {}
        @_size = 0

    add: (value) ->
        if not @contains(value)
            @_size++
        @_values[@_hashFunction(value)] = value


    remove: (value) ->
        if @contains(value)
            delete @_values[@_hashFunction(value)]
            @_size--

    contains: (value) ->
        @_hashFunction(value) of @_values

    size: ->
        @_size

    each: (func, thisCtx) ->
        for key, value of @_values
            func.call(thisCtx, value)

    rawValues: ->
        @_values

    toArray: ->
        _.map @_values, (val, key) -> val


@Set = Set

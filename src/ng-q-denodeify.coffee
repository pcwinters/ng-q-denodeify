angular.module('$q.denodeify', [])
.config ($provide) ->
	$provide.decorator '$q', ($delegate) ->
		$delegate.denodeify = (fn)->
			return _.wrap fn, (fn, args...)->
				deferred = $delegate.defer()
				callback = (err, result)->
					if err?
						deferred.reject(err)
					else
						deferred.resolve(result)
				fn.apply @, args.concat [callback]
				return deferred.promise
		return $delegate

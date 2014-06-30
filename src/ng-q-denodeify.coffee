angular.module('$q.denodeify', [])
.config ($provide) ->
	$provide.decorator '$q', ($delegate, $rootScope) ->
		$delegate.denodeify = (fn, digest=true)->
			return _.wrap fn, (fn, args...)->
				deferred = $delegate.defer()
				callback = (err, result)->
					if err?
						deferred.reject(err)
					else
						deferred.resolve(result)
					if digest and not $rootScope.$$phase
						$rootScope.$digest()
				fn.apply @, args.concat [callback]
				return deferred.promise
		return $delegate

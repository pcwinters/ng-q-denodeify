var __slice = [].slice;

angular.module('$q.denodeify', []).config(function($provide) {
  return $provide.decorator('$q', function($delegate, $rootScope) {
    $delegate.denodeify = function(fn, digest) {
      if (digest == null) {
        digest = true;
      }
      return _.wrap(fn, function() {
        var args, callback, deferred, fn;
        fn = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        deferred = $delegate.defer();
        callback = function(err, result) {
          if (err != null) {
            deferred.reject(err);
          } else {
            deferred.resolve(result);
          }
          if (digest && !$rootScope.$$phase) {
            return $rootScope.$digest();
          }
        };
        fn.apply(this, args.concat([callback]));
        return deferred.promise;
      });
    };
    return $delegate;
  });
});

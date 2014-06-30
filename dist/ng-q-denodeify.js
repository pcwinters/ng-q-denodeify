var __slice = [].slice;

angular.module('$q.denodeify', []).config(function($provide) {
  return $provide.decorator('$q', function($delegate) {
    $delegate.denodeify = function(fn) {
      return _.wrap(fn, function() {
        var args, callback, deferred, fn;
        fn = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        deferred = $delegate.defer();
        callback = function(err, result) {
          if (err != null) {
            return deferred.reject(err);
          } else {
            return deferred.resolve(result);
          }
        };
        fn.apply(this, args.concat([callback]));
        return deferred.promise;
      });
    };
    return $delegate;
  });
});

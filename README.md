[![Build Status](https://travis-ci.org/pcw216/ng-q-denodeify.svg?branch=master)](https://travis-ci.org/pcw216/ng-q-denodeify)
ng-q-denodeify
==============

Denodeify for Angular's $q

Installation
==

You can install the module using bower:
```
bower install --save ng-q-denodeify
```
Then list it as a module dependency
```
angular.module('MyApp', ['$q.denodeify'])
```

Usage
==
$q.denodeify should work similar to Q.denodeify, with an optional second argument to force a $digest upon callback/resolution (defaults to true).
```
$q.denodeify(async.auto, true)(
  [1,2,3], 
  function(item){
    return item;
  }
).then(function(result){
  console.log(result);
})
// should print [1,2,3]
```

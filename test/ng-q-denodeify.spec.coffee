describe '$q.denodeify', ->

	beforeEach ->
		@addMatchers({
			toBeAFunction: ()->
				return typeof @actual  is 'function'
		})

	beforeEach ->
		angular.mock.module('$q.denodeify')
		inject (@$q, @$rootScope)->

	it 'should add a denodeify method to $q', ()->
		expect(@$q.denodeify).toBeDefined()

	describe 'denodeify', ->

		beforeEach ->
			@spy = jasmine.createSpy('originalFn')
			@wrapped = @$q.denodeify(@spy)

		it 'should wrap a function', ->
			
			expect(@wrapped).not.toBe(@spy)
			expect(@wrapped).toBeAFunction()

		it 'should wrap and return a promise', ->
			result = @wrapped()
			expect(result.then).toBeAFunction()

		it 'should invoke the wrapped function', ->
			result = @wrapped()
			expect(@spy).toHaveBeenCalled()

		describe 'callback resolution', ->

			it 'should resolve the promise with callback result', ->
				@spy.andCallFake (args...)->
					_.last(args)(null, 'foo')

				success = jasmine.createSpy('success')
				@wrapped().then(success)
				@$rootScope.$digest()
				expect(success).toHaveBeenCalledWith('foo')

			it 'should resolve the promise with undefined if callback has no result', ->
				@spy.andCallFake (args...)->
					_.last(args)()

				success = jasmine.createSpy('success')
				@wrapped().then(success)
				@$rootScope.$digest()
				expect(success).toHaveBeenCalled()

			it 'should reject the promise with callback err', ->
				@spy.andCallFake (args...)->
					_.last(args)('err')

				success = jasmine.createSpy('success')
				failure = jasmine.createSpy('failure')
				@wrapped().then(success, failure)
				@$rootScope.$digest()
				expect(failure).toHaveBeenCalledWith('err')



/*

import Elm.Kernel.Platform exposing (initialize)

*/



// NODECLI PROGRAMS


var _NodeCli_program = F4(function(impl, flagDecoder, debugMetadata, args)
{
  return _Platform_intialize(
    flagDecoder,
    args,
    impl.__$init,
    impl.__$update,
    impl.__$subscriptions,
    function() { return function() {} }
  );
});

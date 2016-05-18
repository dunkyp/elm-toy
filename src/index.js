// pull in desired CSS/SASS files
require( './styles/mt.css/mt.scss' );
require( './styles/app.css' );

var Elm = require( './Main.elm' );
Elm.Main.embed( document.getElementById( 'main' ) );

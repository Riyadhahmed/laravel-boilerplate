<?php

Route::group([
  'namespace' => 'Frontend',
  'as' => 'frontend.'],
  function () {
     require base_path('routes/frontend/frontend.php');
  });


// Bakcend


// Admin Auth
Route::prefix('admin_login')->group(function () {
   Route::get('login', 'Auth\Admin\LoginController@login')->name('admin.auth.login');
   Route::post('login', 'Auth\Admin\LoginController@loginAdmin')->name('admin.auth.loginAdmin');
   Route::post('logout', 'Auth\Admin\LoginController@logout')->name('admin.auth.logout');
});

// Admin Dashborad
Route::group([
  'namespace' => 'Backend\Admin',
  'prefix' => 'admin',
  'as' => 'admin.',
  'middleware' => 'auth:admin'],
  function () {
     require base_path('routes/backend/admin.php');
  });



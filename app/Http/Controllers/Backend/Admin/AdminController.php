<?php

namespace App\Http\Controllers\Backend\Admin;

use App\Models\Admin;
use App\Models\Role;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Yajra\DataTables\Facades\DataTables;
use View;
use DB;

class AdminController extends Controller
{

   public function index()
   {
      return view('backend.admin.admin.all');
   }

   public function allAdmin()
   {

      $roles = Role::pluck('name')->all();
      DB::statement(DB::raw('set @rownum=0'));
      $users = Admin::get(['admins.*', DB::raw('@rownum  := @rownum  + 1 AS rownum')]);
      return Datatables::of($users)
        ->addColumn('role', function ($user) use ($roles) {
           return $user->roles->pluck('name')->implode(',');
        })
        ->addColumn('action', 'backend.admin.admin.action')
        ->make(true);
   }

   /**
    * Display a listing of the resource.
    *
    * @return \Illuminate\Http\Response
    */
   public function profile()
   {
      $user = Auth::user();
      return view('backend.admin.admin.profile', compact('user'));
   }

   public function edit()
   {
      $user = Auth::user();
      return view('backend.admin.admin.edit_profile', compact('user'));
   }

   public function update(Request $request)
   {
      if ($request->ajax()) {

         $user = Admin::findOrFail(Auth::user()->id);

         $rules = [
           'name' => 'required',
           'email' => 'required|email|unique:admins,email,' . $user->id,
         ];

         $validator = Validator::make($request->all(), $rules);
         if ($validator->fails()) {
            return response()->json([
              'type' => 'error',
              'errors' => $validator->getMessageBag()->toArray()
            ]);
         } else {

            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->save(); //
            return response()->json(['type' => 'success', 'message' => "Successfully Updated"]);

         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   public function change_password()
   {
      return view('backend.admin.admin.change_password');
   }

   public function update_password(Request $request)
   {
      if ($request->ajax()) {

         $user = Admin::findOrFail(Auth::user()->id);

         $rules = [
           'password' => 'required'
         ];

         $validator = Validator::make($request->all(), $rules);
         if ($validator->fails()) {
            return response()->json([
              'type' => 'error',
              'errors' => $validator->getMessageBag()->toArray()
            ]);
         } else {
            $user->password = Hash::make($request->input('password'));
            $user->save(); //
            return response()->json(['type' => 'success', 'message' => "Successfully Updated"]);
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }
}

<?php

namespace App\Http\Controllers\Backend\Admin;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Spatie\Permission\Models\Role;
use Yajra\DataTables\DataTables;

use Excel;
use View;
use DB;

class UserController extends Controller
{
   /**
    * Display a listing of the resource.
    *
    * @return \Illuminate\Http\Response
    */
   public function index()
   {
      return view('backend.admin.user.index');
   }

   public function allUser()
   {
      $can_edit = $can_delete = '';
      if (!auth()->user()->can('user-edit')) {
         $can_edit = "style='display:none;'";
      }
      if (!auth()->user()->can('user-delete')) {
         $can_delete = "style='display:none;'";
      }

      $roles = Role::pluck('name')->all();
      $users = User::get();
      return Datatables::of($users)
        ->addColumn('role', function ($user) use ($roles) {
           return $user->roles->pluck('name')->implode(',');
        })
        ->addColumn('action', function ($user) use ($can_edit, $can_delete) {
           $html = '<div class="btn-group">';
           $html .= '<a data-toggle="tooltip" ' . $can_edit . '  id="' . $user->id . '" class="btn btn-xs btn-primary margin-r-5 edit" title="Edit"><i class="fa fa-edit fa-fw"></i> </a>';
           $html .= '<a data-toggle="tooltip" ' . $can_delete . ' id="' . $user->id . '" class="btn btn-xs btn-danger margin-r-5 delete" title="Delete"><i class="fa fa-trash-o fa-fw"></i> </a>';
           $html .= '</div>';
           return $html;
        })
        ->rawColumns(['action'])
        ->addIndexColumn()
        ->make(true);
   }


   public function export()
   {
      return Excel::download(new UsersExport, 'users.xlsx');
   }

   /**
    * Show the form for creating a new resource.
    *
    * @return \Illuminate\Http\Response
    */
   public function create(Request $request)
   {
      if ($request->ajax()) {
         $haspermision = auth()->user()->can('user-create');
         if ($haspermision) {
            $roles = Role::get();
            $view = View::make('backend.admin.user.create', compact('roles'))->render();
            return response()->json(['html' => $view]);
         } else {
            abort(403, 'Sorry, you are not authorized to access the page');
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   /**
    * Store a newly created resource in storage.
    *
    * @param  \Illuminate\Http\Request $request
    * @return \Illuminate\Http\Response
    */
   public function store(Request $request)
   {
      if ($request->ajax()) {
         // Setup the validator
         $rules = [
           'name' => 'required',
           'email' => 'required|email|unique:users,email',
           'password' => 'required|same:confirm-password',
           'roles' => 'required'
         ];

         $validator = Validator::make($request->all(), $rules);
         if ($validator->fails()) {
            return response()->json([
              'type' => 'error',
              'errors' => $validator->getMessageBag()->toArray()
            ]);
         } else {
            $input = $request->all();
            $input['password'] = Hash::make($input['password']);
            $user = User::create($input);
            // $roles = explode(",", $request->input('roles')); // if send from ajax apend
            $roles = $request->input('roles');
            if (isset($roles)) {
               $user->assignRole($roles);
            }
            return response()->json(['type' => 'success', 'message' => "Successfully Created"]);
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   /**
    * Display the specified resource.
    *
    * @param  int $id
    * @return \Illuminate\Http\Response
    */
   public function show($id, Request $request)
   {
      if ($request->ajax()) {
         $haspermision = auth()->user()->can('user-view');
         if ($haspermision) {
            $user = User::findOrFail($id); //Get user with specified id
            $roles = $user->getRoleNames();
            $view = View::make('backend.admin.user.view', compact('user', 'roles'))->render();
            return response()->json(['html' => $view]);
         } else {
            abort(403, 'Sorry, you are not authorized to access the page');
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   /**
    * Show the form for editing the specified resource.
    *
    * @param  int $id
    * @return \Illuminate\Http\Response
    */
   public function edit($id, Request $request)
   {
      if ($request->ajax()) {
         $haspermision = auth()->user()->can('user-edit');
         if ($haspermision) {
            $user = User::findOrFail($id); //Get user with specified id
            $roles = Role::get(); //Get all roles
            $view = View::make('backend.admin.user.edit', compact('user', 'roles'))->render();
            return response()->json(['html' => $view]);
         } else {
            abort(403, 'Sorry, you are not authorized to access the page');
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   /**
    * Update the specified resource in storage.
    *
    * @param  \Illuminate\Http\Request $request
    * @param  int $id
    * @return \Illuminate\Http\Response
    */
   public function update(Request $request, User $user)
   {
      if ($request->ajax()) {
         // Setup the validator
         User::findOrFail($user->id);

         $rules = [
           'name' => 'required',
           'email' => 'required|email|unique:users,email,' . $user->id,
           'password' => 'same:confirm-password',
           'roles' => 'required'
         ];

         $validator = Validator::make($request->all(), $rules);
         if ($validator->fails()) {
            return response()->json([
              'type' => 'error',
              'errors' => $validator->getMessageBag()->toArray()
            ]);
         } else {

            $input = $request->all();

            if (!empty($input['password'])) {
               $input['password'] = Hash::make($input['password']);
            } else {
               $input = array_except($input, array('password'));
            }

            $user->update($input);

            // $roles = explode(",", $request->input('roles'));
            //  DB::table('model_has_roles')->where('model_id', $user->id)->delete();

            $roles = $request->input('roles');
            if (isset($roles)) {
               $user->roles()->sync($roles);  //If one or more role is selected associate user to roles
            } else {
               $user->roles()->detach(); //If no role is selected remove exisiting role associated to a user
            }

            return response()->json(['type' => 'success', 'message' => "Successfully Updated"]);
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }

   /**
    * Remove the specified resource from storage.
    *
    * @param  int $id
    * @return \Illuminate\Http\Response
    */
   public function destroy($id, Request $request)
   {
      if ($request->ajax()) {
         $haspermision = auth()->user()->can('user-delete');
         if ($haspermision) {
            $user = User::findOrFail($id); //Get user with specified id
            $user->delete();
            return response()->json(['type' => 'success', 'message' => "Successfully Deleted"]);
         } else {
            abort(403, 'Sorry, you are not authorized to access the page');
         }
      } else {
         return response()->json(['status' => 'false', 'message' => "Access only ajax request"]);
      }
   }
}
